package pl.mgorski.nativeserverless;

import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface PersonMapper {

    PersonMapper INSTANCE = Mappers.getMapper(PersonMapper.class);

    Person fromDto(PersonDTO input);

    PersonDTO toDto(Person input);

}
