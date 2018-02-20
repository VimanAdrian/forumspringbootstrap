package artsoftconsult.study.repository;

import artsoftconsult.study.model.Reply;
import artsoftconsult.study.repository.dbUtils.HibernateUtil;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

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

}
