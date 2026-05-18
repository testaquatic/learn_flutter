use todo_server::router::create_router;
use tokio::net::TcpListener;
use tower_http::trace::TraceLayer;

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt()
        .with_max_level(tracing::Level::TRACE)
        .with_file(true)
        .with_line_number(true)
        .pretty()
        .with_target(true)
        .init();

    let listener = TcpListener::bind("0.0.0.0:3000")
        .await
        .expect("Failed to bind TcpListener");
    let router = create_router().layer(TraceLayer::new_for_http());

    axum::serve(listener, router).await.expect("server error");
}
