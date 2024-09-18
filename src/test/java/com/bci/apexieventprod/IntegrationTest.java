package com.bci.apexieventprod;

import com.bci.apexieventprod.config.AsyncSyncConfiguration;
import com.bci.apexieventprod.config.EmbeddedElasticsearch;
import com.bci.apexieventprod.config.EmbeddedKafka;
import com.bci.apexieventprod.config.EmbeddedRedis;
import com.bci.apexieventprod.config.EmbeddedSQL;
import com.bci.apexieventprod.config.JacksonConfiguration;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * Base composite annotation for integration tests.
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@SpringBootTest(classes = { ApexiEventProdApp.class, JacksonConfiguration.class, AsyncSyncConfiguration.class })
@EmbeddedRedis
@EmbeddedElasticsearch
@EmbeddedSQL
@EmbeddedKafka
public @interface IntegrationTest {
}
