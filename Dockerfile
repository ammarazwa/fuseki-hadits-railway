FROM stain/jena-fuseki:latest

# Switch to root untuk install dan copy files
USER root

# Set environment variables
ENV ADMIN_PASSWORD=admin123
ENV JVM_ARGS=-Xmx512m
ENV FUSEKI_HOME=/fuseki

# Buat direktori staging untuk data RDF
RUN mkdir -p /staging

# Copy konfigurasi dataset
COPY dataset_hadits.ttl /fuseki/configuration/dataset_hadits.ttl

# Copy file RDF (TTL) kamu ke /staging
# Taruh file knowledge_graph.ttl dan ontology_schema.ttl di folder data/
COPY data/ /staging/

# Copy dan set permission entrypoint
COPY entrypoint.sh /entrypoint-custom.sh
RUN chmod +x /entrypoint-custom.sh

# Expose port Fuseki
EXPOSE 3030

# Jalankan entrypoint custom
ENTRYPOINT ["/entrypoint-custom.sh"]
