package kr.ywhs.dao;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StoreBizDAO implements StoreInfoDAO{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<InventoryVO> searchStoreSS(Map<String, Object> paramMap) {
		List<InventoryVO> result = sqlSession.selectList("kr.ywhs.mapper.searchStoreSS", paramMap);
		return result;
	}

}
