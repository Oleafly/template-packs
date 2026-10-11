#import "@preview/codelst:2.0.2": sourcecode

#set page(margin: 2.5cm)
#counter(heading).update(0)
#pagebreak(to:"even")

#heading(level: 1, numbering: "A", outlined: true)[
  Appendix
] <sec:appendix_a>

#figure(
sourcecode(
    ```yaml
    entity platform {
        relation super_admin @user
        permission manage_tenants = super_admin
    }

    entity tenant {
        relation admin      @user | @user_group#member
        relation maintainer @user | @user_group#member
        relation member     @user | @user_group#member

        permission is_admin      = admin
        permission is_maintainer = maintainer
        permission is_member     = member

        permission manage_structure = is_admin or is_maintainer
        permission view_structure   = manage_structure or is_member
    }

    entity macro_section {
        [...]
    }

    entity section {
    [...]
    }

    entity device_type {
        attribute can_pub_data  boolean
        attribute can_issue_cmd boolean
        // ... other capability attributes

        permission allowed_pub_data   = can_pub_data
        permission allowed_issue_cmd  = can_issue_cmd
        // ... other permissions derived from attributes
    }

    entity device {
        relation section    @section
        relation type       @device_type
        relation controller @user | @user_group#member

        permission publish_data = type.can_pub_data
        permission subscribe_cmd = type.can_sub_cmd
        permission receive_cmd  = section.operate_devices or controller
        permission read_data    = section.view_data
    }
    ```
),
caption: "Permify schema example",
) <code:permify_schema_example>

#figure(
  sourcecode(
```go
  reqBody := PermifyCheckRequest{
    Metadata: PermifyMetadata{
      SnapToken:     "",
      SchemaVersion: "",
      Depth:         100,
    },
    Entity: PermifyEntity{
      Type: entityType,
      ID:   entityID,
    },

    Permission: permission,

    Subject: PermifySubject{
      Type: subjectType,
      ID:   subjectID,
    },
  }
```
  ), caption: "Example of a permission check request to Permify"
) <code:permify_check_request_example>

#v(1em)

#figure(
sourcecode(
```yaml
  vernemq2:
    image: vernemq-from-source:latest
    container_name: vernemq2
    labels:
      - "traefik.enable=true"
      
      # MQTT TCP (port 1883) - Load balanced
      - "traefik.tcp.routers.mqtt.entrypoints=mqtt"
      - "traefik.tcp.routers.mqtt.rule=HostSNI(`*`)"
      - "traefik.tcp.routers.mqtt.service=mqtt-backend"
      
      # MQTT TLS (:8883)
      - "traefik.tcp.routers.mqtt-secure.entrypoints=mqtts"
      - "traefik.tcp.routers.mqtt-secure.rule=HostSNI(`*`)"
      - "traefik.tcp.routers.mqtt-secure.tls=true"
      - "traefik.tcp.routers.mqtt-secure.tls.certresolver=letsencrypt 
      - "traefik.tcp.routers.mqtt-secure.service=mqtt-backend"

    environment:
      - DOCKER_VERNEMQ_ALLOW_ANONYMOUS=off
      # Disable built-in ACLs to use only the webhook authentication/authorization
      - DOCKER_VERNEMQ_PLUGINS__VMQ_ACL=off
      # plugin webhooks managed via vernemq.confs
      - DOCKER_VERNEMQ_PLUGINS__VMQ_WEBHOOKS=on
      # Webhooks pointing to auth-service
      - DOCKER_VERNEMQ_VMQ_WEBHOOKS__JWT_AUTH__HOOK=auth_on_register
      - DOCKER_VERNEMQ_VMQ_WEBHOOKS__JWT_AUTH__ENDPOINT=http://auth-service:8080/auth_on_register
      - DOCKER_VERNEMQ_VMQ_WEBHOOKS__JWT_PUBLISH__HOOK=auth_on_publish
      - DOCKER_VERNEMQ_VMQ_WEBHOOKS__JWT_PUBLISH__ENDPOINT=http://auth-service:8080/auth_on_publish
      - DOCKER_VERNEMQ_VMQ_WEBHOOKS__JWT_SUBSCRIBE__HOOK=auth_on_subscribe
      - DOCKER_VERNEMQ_VMQ_WEBHOOKS__JWT_SUBSCRIBE__ENDPOINT=http://auth-service:8080/auth_on_subscribe
      - DOCKER_VERNEMQ_VMQ_WEBHOOKS__ON_CLIENT_OFFLINE__HOOK=on_client_offline
      - DOCKER_VERNEMQ_VMQ_WEBHOOKS__ON_CLIENT_OFFLINE__ENDPOINT=http://auth-service:8080/on_client_offline
      - DOCKER_VERNEMQ_VMQ_WEBHOOKS__ON_CLIENT_GONE__HOOK=on_client_gone
      - DOCKER_VERNEMQ_VMQ_WEBHOOKS__ON_CLIENT_GONE__ENDPOINT=http://auth-service:8080/on_client_gone

      # auto-join cluster to first node
      - DOCKER_VERNEMQ_DISCOVERY_NODE=${VERNEMQ_IP_1}
    networks:
      vernemq-net:
        ipv4_address: ${VERNEMQ_IP_2}
    depends_on:
      - vernemq1
```
), caption: "VerneMQ configuration in Docker Compose - relevant parts"
) <code:vernemq_docker_compose>
#v(2em)

#figure(
sourcecode(
    ```go
    func main() {
      [...]

      r.POST("/auth_on_register", authOnRegister)
      r.POST("/auth_on_publish", authOnPublish)
      r.POST("/auth_on_subscribe", authOnSubscribe)
      r.POST("/on_client_offline", onClientOffline)
      r.POST("/on_client_gone", onClientGone)
      
      [...]
    }
    ```
), caption: "Auth service - webhook endpoints handlers"
) <code:auth_service_webhook_handlers>

#v(2em)

#figure(
sourcecode(
```json
{
  "name": "IOT_INCOMING_DATA",
  "subjects": ["incoming.mqtt.>", "incoming.coap.>", "outcoming.coap.>", "outcoming.mqtt.>"],
  "retention": "limits",
  "max_consumers": -1,
  "max_msgs": 100000,
  "max_bytes": -1,
  "max_age": 86400000000000,
  "storage": "file",
  "num_replicas": 3
}
```
), caption: "NATS JetStream stream configuration"
) <code:nats_jetstream_stream_config>
#v(2em)

#figure(
sourcecode(
```go
  dtlsConfig := &piondtls.Config{
    PSK: func(hint []byte) ([]byte, error) {
      deviceHint := string(hint)
      log.Printf("DTLS Handshake: Authenticating device '%s'", deviceHint)
      
      key, err := pskStore.GetKey(hint)
      if err != nil {
        log.Printf("Authentication failed for device '%s': %v", deviceHint, err)
        return nil, err
      }
      
      log.Printf("✓ Device '%s' authenticated", deviceHint)
      return key, nil
    },
    PSKIdentityHint: []byte("coap-bridge-server"),
    CipherSuites: []piondtls.CipherSuiteID{
      piondtls.TLS_PSK_WITH_AES_128_CCM_8,
      piondtls.TLS_PSK_WITH_AES_128_GCM_SHA256,
    },
  }
```
), caption: "DTLS configuration with PSK callback function"
) <code:dtls_config_with_psk_callback>

#figure(
  sourcecode(
  ```go
type InputPayload struct {
    DeviceID string          `json:"device"`
    Type     string          `json:"type"`
    Ts       int64           `json:"ts"`
    Data     json.RawMessage `json:"data"`
    TenantID string          `json:"tenant_id"`

    [...]

    tableName := tenantTableName(payload.TenantID)
    // Create the table if it doesn't exist (only for 1st message)
    if res := db.Table(tableName).Create(&dbRecord); res.Error != nil {
      log.Printf("DB Insert Error (table %q): %v", tableName, res.Error)
      msg.Nak()
    } else {
      log.Printf("Saved to %q: device=%s tenant=%s", tableName, payload.DeviceID, payload.TenantID)
      msg.Ack()
    }
  }
}
```
), caption: "DB Writer input payload structure"
) <code:data_writer_input_payload>

