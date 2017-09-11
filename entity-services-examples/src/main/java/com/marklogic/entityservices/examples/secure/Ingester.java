package com.marklogic.entityservices.examples.secure;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.marklogic.client.datamovement.WriteBatcher;
import com.marklogic.client.document.ServerTransform;
import com.marklogic.client.io.JacksonHandle;
import com.marklogic.entityservices.examples.ExamplesBase;
import io.codearte.jfairy.Fairy;
import io.codearte.jfairy.producer.person.Person;

import javax.sound.midi.Sequence;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Random;

public class Ingester extends ExamplesBase {

    protected String getExampleName() {
        return "example-els";
    }

    public Ingester() {
        super("secured-app.properties");
    }

    public void generateOrders(int n) throws IOException {

        Fairy fairy = Fairy.create();

        ObjectMapper mapper = new ObjectMapper();
        WriteBatcher batcher = super.newBatcher()
            .withTransform(new ServerTransform("ingest-customer"));

        moveMgr.startJob(batcher);

        /* Load the model */
        importJSON(Paths.get(projectDir + "/Customer-pii-0.0.1.json"), "http://marklogic.com/entity-services/models");


        for (int i=0; i < n; i++) {
            Person p = fairy.person();
            Customer customer = new Customer();
            customer.setId("" + i);
            customer.setName(p.getFirstName());
            customer.setEmail(p.getEmail());
            customer.setSsn(p.getNationalIdentityCardNumber());
            JsonNode asNode = mapper.convertValue(customer, ObjectNode.class);
            batcher.add("/customer/" + i + ".json", new JacksonHandle().with(asNode));
        }

        batcher.flushAndWait();
        moveMgr.stopJob(batcher);
    }

    public static void main(String[] args) throws IOException {
        Ingester ingester = new Ingester();

        ingester.generateOrders(10);


    }
}
