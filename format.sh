docker run --rm \
  -v $PWD/kafka-data/controller1:/var/lib/kafka/data \
  -v $PWD/configs/kafka.properties:/etc/kafka/kafka.properties \
  confluentinc/cp-server:7.7.1 \
  kafka-storage format \
    --ignore-formatted \
    --cluster-id MkU3OEVBNTcwNTJENDM2Qk \
    --config /etc/kafka/kafka.properties

docker run --rm \
  -v $PWD/kafka-data/controller2:/var/lib/kafka/data \
  -v $PWD/configs/kafka.properties:/etc/kafka/kafka.properties \
  confluentinc/cp-server:7.7.1 \
  kafka-storage format \
    --ignore-formatted \
    --cluster-id MkU3OEVBNTcwNTJENDM2Qk \
    --config /etc/kafka/kafka.properties


docker run --rm \
  -v $PWD/kafka-data/controller3:/var/lib/kafka/data \
  -v $PWD/configs/kafka.properties:/etc/kafka/kafka.properties \
  confluentinc/cp-server:7.7.1 \
  kafka-storage format \
    --ignore-formatted \
    --cluster-id MkU3OEVBNTcwNTJENDM2Qk \
    --config /etc/kafka/kafka.properties
