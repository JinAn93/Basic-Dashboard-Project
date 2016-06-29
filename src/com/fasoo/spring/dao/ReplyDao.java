package com.fasoo.spring.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.fasoo.spring.model.Reply;

@Repository("replyDao")
public class ReplyDao extends AbstractDao<Integer, Reply> implements IReplyDao {

	public Reply findById(int id) {
		return getByKey(id);
	}

	public void saveReply(Reply reply) {
		persist(reply);
	}

	@SuppressWarnings("unchecked")
	public List<Reply> findAllReplies() {
		Criteria criteria = createEntityCriteria();
		return (List<Reply>) criteria.list();
	}

	@SuppressWarnings("unchecked")
	public List<Reply> findByPostId(int post_id) {
		return createEntityCriteria().add(Restrictions.eqOrIsNull("post_id", post_id)).list();
	}

	public void deleteReplyById(int id) {
		Query query = getSession().createSQLQuery("delete from Replies where id = :id");
		query.setInteger("id", id);
		query.executeUpdate();
	}
}
