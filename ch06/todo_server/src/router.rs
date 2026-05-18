use std::sync::Arc;

use axum::{
    Router,
    routing::{get, put},
};
use tokio::sync::Mutex;
use utoipa::{
    OpenApi,
    openapi::{Info, OpenApiBuilder},
};
use utoipa_swagger_ui::SwaggerUi;

use crate::{
    database::inmemory::InMemoryTodoDatabase,
    handler::todos::{TodosOpenApi, create_todo, delete_todo, get_todo, update_todo},
    service::todo_service::TodoService,
};

#[derive(Clone)]
pub struct AppState {
    _database: Arc<Mutex<InMemoryTodoDatabase>>,
    pub todo_service: TodoService,
}

pub fn create_router() -> Router<()> {
    let database = Arc::new(Mutex::new(InMemoryTodoDatabase::new()));
    let todo_service = TodoService::new(database.clone());

    let state = AppState {
        _database: database,
        todo_service,
    };

    Router::new()
        .route("/todos", get(get_todo).post(create_todo))
        .route("/todos/{id}", put(update_todo).delete(delete_todo))
        .merge(swagger_router())
        .with_state(state)
}

pub fn swagger_router() -> SwaggerUi {
    let mut openapi = OpenApiBuilder::new()
        .info(Info::new("todo_server", "0.1"))
        .build();

    openapi.merge(TodosOpenApi::openapi());

    SwaggerUi::new("/swagger").url("/api-docs/openapi.json", openapi)
}
