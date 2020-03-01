package pl.mgorski.nativeserverless;

import lombok.RequiredArgsConstructor;

import javax.inject.Singleton;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;

@Singleton
@RequiredArgsConstructor
public class PersonRepository {

    private final EntityManager entityManager;

    void save(Person person) {
        entityManager.persist(person);
    }

    public List<Person> findAll() {
        Query query = entityManager.createNamedQuery("Person.findAll");
        return query.getResultList();
    }

}
