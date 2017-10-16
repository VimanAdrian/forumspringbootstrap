package artsoftconsult.study.repository;

import artsoftconsult.study.model.Post;
import artsoftconsult.study.model.User;
import artsoftconsult.study.repository.dbUtils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.util.List;

@Repository
public abstract class HibernateRepository {

    //saves in db
    public Integer saveHibernate(Object object) {
        Integer generatedId = -1;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            generatedId = (Integer) session.save(object);
            session.getTransaction().commit();
            //close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw e;
        } finally {
            if (session != null) {
                session.close();
            }
        }
        HibernateUtil.shutdown();
        return generatedId;
    }

    //deletes from db

    public void deleteHibernate(Object object) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            session.delete(object);
            session.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    //updates db
    public void updateHibernate(Object object) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            session.update(object);
            session.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(e.toString());
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }


    public void joinulLuiStefii() {
        Transaction tx = null;
        try {
            Session session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            String hql = "SELECT user.username FROM User user JOIN HibernateUti uti ON uti.user.userId=user.userId WHERE uti.isEnabled=1";
            Query query = session.createQuery(hql);
            List result = query.list();
            tx.commit();
            System.out.println(result);
        } catch (Exception e) {
            tx.rollback();
            System.out.println(e.getMessage());
        }
    }
}
