package kr.ywhs.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public interface StoreInfoDAO {
	public List<InventoryVO> searchStoreSS(Map<String, Object> paramMap); // 매장명 검색
}
