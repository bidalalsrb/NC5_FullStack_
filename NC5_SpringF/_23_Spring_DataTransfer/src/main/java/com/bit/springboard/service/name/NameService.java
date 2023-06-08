package com.bit.springboard.service.name;

import java.util.List;

import com.bit.springboard.dto.NameDTO;

public interface NameService {
	void insertName(NameDTO nameDTO);
	
	List<NameDTO> getNameList();
}
