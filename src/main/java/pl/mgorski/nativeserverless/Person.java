package pl.mgorski.nativeserverless;

import lombok.Data;
import org.hibernate.annotations.Immutable;

import javax.persistence.*;

@Entity
@Data
@Immutable
@Table(name = "persons")
@NamedQueries({
        @NamedQuery(name = "Person.findAll", query = "SELECT p From Person p")
})
public class Person {

    @Id
    @SequenceGenerator(sequenceName = "persons_id_seq",name = "generator_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "generator_seq")
    @Column(name = "id")
    private Long id;

    @Column(name = "name")
    private String name;

}
