import consumer from "./consumer"

var id = document.URL.split('/').slice(-2)[0]
console.log(id)

consumer.subscriptions.create(
  {
    channel: 'DraftChannel',
    id: id
  },
  {
    received(data) {
      if (data.cableReady) CableReady.perform(data.operations)
    }
  }
);
