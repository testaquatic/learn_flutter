use axum::{
    Json,
    extract::{Path, State},
    http::StatusCode,
};

use crate::{model::todo::Todo, router::AppState, service::error::ServiceError};

#[utoipa::path(
  get,
  path = "/todos",
  description = "전체 일정을 불러온다",
  tag = "todos",
  summary = "전체 일정 조회",
  responses(
    (status = StatusCode::OK, content_type = "application/json", description = "목록을 반환", body = Vec<Todo>)
  )
)]
pub async fn get_todo(State(state): State<AppState>) -> Result<Json<Vec<Todo>>, ServiceError> {
    state.todo_service.get_all().await.map(Json)
}

#[utoipa::path(
  post,
  path = "/todos",
  description = "일정을 추가한다",
  summary = "일정 추가",
  tag = "todos",
  request_body(content = Todo, content_type = "application/json"),
  responses(
    (status = StatusCode::OK, description = "일정을 추가함", body = Todo, content_type = "application/json")
  )
)]
#[tracing::instrument(skip_all)]
pub async fn create_todo(
    State(state): State<AppState>,
    Json(todo): Json<Todo>,
) -> Result<Json<Todo>, ServiceError> {
    state.todo_service.create_todo(todo).await.map(Json)
}

#[utoipa::path(
  put,
  path = "/todos/{id}",
  description = "일정을 수정한다",
  summary = "일정을 수정",
  tag = "todos",
  request_body(content = Todo, content_type = "application/json"),
  responses(
    (status = StatusCode::OK, description = "일정을 수정함", body = Todo, content_type = "application/json"),
    (status = StatusCode::NOT_FOUND, description = "존재하지 않는 일정"),
    (status = StatusCode::BAD_REQUEST, description = "잘못된 요청"),
  )
)]
#[tracing::instrument(skip_all)]
pub async fn update_todo(
    State(state): State<AppState>,
    Path(id): Path<String>,
    Json(todo): Json<Todo>,
) -> Result<Json<Todo>, ServiceError> {
    if id != todo.id {
        return Err(ServiceError::BadRequest(format!(
            "id({id}) != todo.id{}",
            todo.id
        )));
    }
    state.todo_service.update(todo).await.map(Json)
}

#[utoipa::path(
  delete,
  path = "/todos/{id}",
  description = "일정을 삭제한다",
  summary = "일정 삭제",
  tag = "todos",
  responses(
    (status = StatusCode::OK, description = "일정을 삭제함"),
    (status = StatusCode::NOT_FOUND, description = "존재하지 않는 일정")
  )
)]
#[tracing::instrument(skip_all)]
pub async fn delete_todo(
    State(state): State<AppState>,
    Path(id): Path<String>,
) -> Result<StatusCode, ServiceError> {
    state.todo_service.delete(id).await.map(|_| StatusCode::OK)
}

#[derive(utoipa::OpenApi)]
#[openapi(paths(get_todo, create_todo, update_todo, delete_todo))]
pub struct TodosOpenApi;
