#import "../../lib.typ": unnumbered, appendix

#show heading.where(level: 1): it => {
  if it.numbering == none and it.body == [Приложения] {
    hide(it)
  } else {
    it
  }
}

#unnumbered[Приложения]

#appendix[

= Полная реализация конечного автомата узла Raft

#figure(
  ```go
  package raft

  import (
      "sync"
      "time"
  )

  type NodeState int

  const (
      Follower NodeState = iota
      Candidate
      Leader
  )

  type LogEntry struct {
      Term    uint64
      Command []byte
  }

  type RaftNode struct {
      mu            sync.Mutex
      id            NodeID
      peers         []Transport
      currentTerm   uint64
      votedFor      NodeID
      log           []LogEntry
      commitIndex   uint64
      lastApplied   uint64
      state         NodeState
      electionTimer *time.Timer
  }

  // becomeFollower переводит узел в состояние последователя.
  // Должен вызываться с захваченным мьютексом.
  func (n *RaftNode) becomeFollower(term uint64) {
      n.state = Follower
      n.currentTerm = term
      n.votedFor = NoNode
  }

  // startElection инициирует выборы: увеличивает срок,
  // голосует за себя и рассылает RequestVote.
  func (n *RaftNode) startElection() {
      n.mu.Lock()
      n.currentTerm++
      n.state = Candidate
      n.votedFor = n.id
      term := n.currentTerm
      lastIdx := uint64(len(n.log))
      lastTerm := uint64(0)
      if lastIdx > 0 {
          lastTerm = n.log[lastIdx-1].Term
      }
      n.mu.Unlock()

      votes := 1
      for _, peer := range n.peers {
          go func(p Transport) {
              resp := p.RequestVote(&RequestVoteReq{
                  Term:         term,
                  CandidateID:  n.id,
                  LastLogIndex: lastIdx,
                  LastLogTerm:  lastTerm,
              })
              n.mu.Lock()
              defer n.mu.Unlock()
              if resp.VoteGranted && n.state == Candidate {
                  votes++
                  if votes > len(n.peers)/2 {
                      n.becomeLeader()
                  }
              }
          }(peer)
      }
  }
  ```,
  caption: [Реализация выборов лидера (`raft/node.go`)],
)

= Конфигурация кластера (пример)

Ниже приведён пример YAML-конфигурации трёхузлового кластера:

```yaml
cluster:
  nodes:
    - id: 1
      addr: "10.0.0.1:7000"
    - id: 2
      addr: "10.0.0.2:7000"
    - id: 3
      addr: "10.0.0.3:7000"

raft:
  heartbeat_ms: 50
  election_timeout_min_ms: 150
  election_timeout_max_ms: 300
  snapshot_threshold: 10000
```

]
