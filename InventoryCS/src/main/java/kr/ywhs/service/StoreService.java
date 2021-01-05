package kr.ywhs.service;

import java.util.List;
import java.util.Map;

import kr.ywhs.dao.InventoryVO;
import kr.ywhs.dao.StoreBizDAO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StoreService {
	
	@Autowired
	private StoreBizDAO storeBizDAO;
	
	public List<InventoryVO> searchStoreSS(Map<String,Object> paramMap) {
		return storeBizDAO.searchStoreSS(paramMap);
	}
	
/*	public void addBookMark(String storeName) {
		storeBizDAO.addBookMark(storeName);
	}
	
	public int deleteBookMark(String storeName) {
		return storeBizDAO.deleteBookMark(storeName);
		
	}*/
	
}
