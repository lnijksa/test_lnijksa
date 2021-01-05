package kr.ywhs.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public interface ProductInfoDAO {
	public ArrayList searchProductPS(Map<String,Object> m);//상품명으로 검색
}
