package kr.ywhs.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductBizDAO implements ProductInfoDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList searchProductPS(Map<String,Object> m) {
		ArrayList m1=new ArrayList();
		m1=(ArrayList) sqlSession.selectList("kr.ywhs.mapper.searchProductPS", m);
		return m1;
	}
}
