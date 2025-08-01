# Container로 JDBC 드라이버 전송
docker cp ~/jdbc/usr/share/java/mysql-connector-j-8.4.0.jar kafka-connect1:/usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib/
docker cp ~/jdbc/usr/share/java/mysql-connector-j-8.4.0.jar kafka-connect2:/usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib/

docker restart kafka-connect1
docker restart kafka-connect2