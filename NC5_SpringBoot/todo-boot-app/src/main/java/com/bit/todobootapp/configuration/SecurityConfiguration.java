package com.bit.todobootapp.configuration;

import com.bit.todobootapp.jwt.JwtAuthenticationFilter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.filter.CorsFilter;

@Configuration
//Security filterchain을 구성하기 위한 어노테이션
@EnableWebSecurity
public class SecurityConfiguration {
    @Autowired
    private JwtAuthenticationFilter jwtAuthenticationFilter;

    //비밀번호 암호화를 위한 PasswordEncoder
    //복호화가 불가능. match라는 메소드를 이용해서 사용자의 입력값과 DB의 저장값을 비교
    // => true나 false 리턴, match(암호화되지 않은 값, 암호화된 값)
    @Bean
    public static PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    //필터 체인 구현(HttpSecurity 객체 사용)
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        return http
                .cors(httpSecurityCorsConfigurer -> {

                })
                //csrf 공격에 대한 옵션 꺼두기
                .csrf(AbstractHttpConfigurer::disable)
                //jwt 토큰 방식으로 인증처리를 하기 때문에 basic 인증방식 비활성화
                .httpBasic(httpSecurityHttpBasicConfigurer -> {
                    httpSecurityHttpBasicConfigurer.disable();
                })
                //토큰방식을 사용하기 때문에 세션방식 사용하지 않도록 설정
                .sessionManagement(httpSecuritySessionManagementConfigurer -> {
                    httpSecuritySessionManagementConfigurer.sessionCreationPolicy(SessionCreationPolicy.STATELESS);
                })
                //요청 주소에 대한 권한 설정
                .authorizeHttpRequests((authorizeRequests) -> {
                    //'/'요청과 '/api/mkember/'로 시작하는 모든 요청은 모든 사용자가 이용가능
                    authorizeRequests.requestMatchers("/", "/api/member/**").permitAll();
                    authorizeRequests.anyRequest().authenticated();
                })
                //filter 등록
                //매요청마다 corsfilter 실행 후 jwtAuthenticationFilter 실행
                .addFilterAfter(jwtAuthenticationFilter, CorsFilter.class)
                .build();
    }


}
