#!/bin/bash

# Kafka Connect 설정 파일 생성 스크립트

# JDBC MySQL Source 커넥터 설정 파일 생성
cat > jdbc-mysql-source.json << 'EOF'
{
    "name": "jdbc-mysql-source",
    "config": {
        "name": "jdbc-mysql-source",
        "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
        "connection.url": "jdbc:mysql://tg-mysqldb.crg0k08ees5f.ap-northeast-2.rds.amazonaws.com:3306/tgmysqlDB",
        "connection.user": "tgadmin",
        "connection.password": "tgadmin1!",
        "db.timezone": "Asia/Seoul",
        "tasks.max": "1",
        "table.whitelist": "tgmysqlDB.user",
        "key.converter": "io.confluent.connect.avro.AvroConverter",
        "key.converter.schema.registry.url": "http://3.36.255.131:8081,http://43.203.57.186:8081",
        "value.converter": "io.confluent.connect.avro.AvroConverter",
        "value.converter.schema.registry.url": "http://3.36.255.131:8081,http://43.203.57.186:8081",
        "topic.creation.default.partitions": "1",
        "topic.creation.default.replication.factor": "3",
        "topic.prefix": "source-",
        "mode": "incrementing",
        "incrementing.column.name": "user_id",
        "transforms": "createKey",
        "transforms.createKey.type": "org.apache.kafka.connect.transforms.ValueToKey",
        "transforms.createKey.fields": "user_id"
    }
}
EOF

echo "✅ jdbc-mysql-source.json 파일이 생성되었습니다."

# JDBC PostgreSQL Sink 커넥터 설정 파일 생성
cat > jdbc-postgre-sink-test.json << 'EOF'
{
    "name": "jdbc-postgre-sink-test",
    "config": {
        "name": "jdbc-postgre-sink-test",
        "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
        "connection.url": "jdbc:postgresql://tg-postgredb.crg0k08ees5f.ap-northeast-2.rds.amazonaws.com:5432/tgpostgreDB",
        "connection.user": "tgadmin",
        "connection.password": "tgadmin1!",
        "db.timezone": "Asia/Seoul",
        "tasks.max": "1",
        "insert.mode": "upsert",
        "pk.mode": "record_key",
        "pk.fields": "user_id",
        "table.name.format": "${topic}",
        "auto.create": "true",
        "auto.evolve": "true",
        "topics": "source-user"
    }
}
EOF
