package kr.ywhs.service;

import java.util.ArrayList;
import java.util.Map;

import kr.ywhs.dao.ProductBizDAO;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductService {
	@Autowired
	ProductBizDAO productBizDAO;
	
	public ArrayList searchProductPS(Map<String,Object> m) {
	return productBizDAO.searchProductPS(m);
	}
}
