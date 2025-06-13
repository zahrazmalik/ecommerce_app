import consumer from "./consumer"

consumer.subscriptions.create(
  {
    channel: "CommentsChannel",
    category_name: document.body.dataset.categoryName,
    product_name: document.body.dataset.productName
  },
  {
    received(data) {
      const commentsContainer = document.getElementById("comments")
      if (commentsContainer) {
        commentsContainer.insertAdjacentHTML('beforeend', data.comment)
      }
    }
  }
)
