package com.bit.springboard.service.name.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bit.springboard.dto.NameDTO;

@Repository("nameDAO")
public class NameDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void insertName(NameDTO nameDTO) {
		mybatis.insert("NameDAO.insertName", nameDTO);
	}
	
	public List<NameDTO> getNameList() {
		return mybatis.selectList("NameDAO.getNameList");
	}
}
