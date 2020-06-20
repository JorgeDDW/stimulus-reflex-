class PostsReflex < ApplicationReflex 

    include CableReady::Broadcaster
    include ActionView::RecordIdentifier

    def repost
        post = Post.find(element.dataset[:id])
        post.increment! :repost_count
        cable_ready["feed"].text_content(
            selector: "##{dom_id(post, "reposts")}",
            text: post.repost_count
        )
        cable_ready.broadcast
    end

    def like
        like = Post.find(element.dataset[:id])
        like.increment! :likes_count
        cable_ready["feed"].text_content(
            selector: "##{dom_id(post, "likes")}",
            text: post.likes_count
        )
        cable_ready.broadcast
    end

end