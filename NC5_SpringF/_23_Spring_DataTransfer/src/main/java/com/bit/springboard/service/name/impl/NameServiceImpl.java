package com.bit.springboard.service.name.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.springboard.dto.NameDTO;
import com.bit.springboard.service.name.NameService;

@Service("nameServiceImpl")
public class NameServiceImpl implements NameService {
	@Autowired
	private NameDAO nameDAO;

	@Override
	public void insertName(NameDTO nameDTO) {
		// TODO Auto-generated method stub
		nameDAO.insertName(nameDTO);
	}

	@Override
	public List<NameDTO> getNameList() {
		// TODO Auto-generated method stub
		return nameDAO.getNameList();
	}
}
