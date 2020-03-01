package pl.mgorski.nativeserverless;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;

@Path("/persons")
@Produces(MediaType.APPLICATION_JSON)
@RequiredArgsConstructor
@Slf4j
public class PersonApi {

    private final PersonService personService;

    @POST
    public Response save(PersonDTO member) {
        log.info("Received item {}", member);
        personService.save(member);
        return Response.status(Response.Status.CREATED).build();
    }

    @GET
    public List<PersonDTO> findAll() {
        log.info("Find all request");
        return personService.findAll();
    }

}
