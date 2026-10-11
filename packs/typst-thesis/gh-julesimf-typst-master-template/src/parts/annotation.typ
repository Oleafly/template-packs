#import "../../lib.typ": annotation

#annotation(
  title-ru: "Программная реализация алгоритма консенсуса Raft\nдля распределённого журнала транзакций",
  author-ru: "Фамилия Имя Отчество",
  body-ru: [
    Задача достижения консенсуса в распределённых системах является одной из
    фундаментальных проблем системного программирования. В данной работе
    реализован алгоритм Raft~--- протокол репликации журнала, разработанный
    как более понятная альтернатива алгоритму Paxos. Реализация выполнена на
    языке Go и обеспечивает устойчивость кластера к отказу меньшинства узлов.
    Проведено сравнение с существующими реализациями по задержке записи и
    пропускной способности. Разработанный модуль может применяться как
    основа для построения отказоустойчивых хранилищ «ключ~-- значение» и
    реплицированных конечных автоматов.
  ],
  title-en: "Software Implementation of the Raft Consensus Algorithm\nfor a Distributed Transaction Log",
  author-en: "Surname Name Patronymic",
  body-en: [
    Achieving consensus in distributed systems is one of the fundamental
    problems in systems programming. This work presents an implementation of
    Raft~--- a replicated log protocol designed as a more understandable
    alternative to Paxos. The implementation is written in Go and guarantees
    cluster availability as long as a majority of nodes are operational.
    The system is benchmarked against existing implementations in terms of
    write latency and throughput. The developed module can serve as a
    foundation for fault-tolerant key-value stores and replicated state machines.
  ],
)
