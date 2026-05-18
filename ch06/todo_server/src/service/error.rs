use axum::{http::StatusCode, response::IntoResponse};

use crate::database::inmemory::DatabaseError;

#[derive(thiserror::Error, Debug)]
pub enum ServiceError {
    #[error("database error")]
    DatabaseError(#[from] DatabaseError),

    #[error("base request")]
    BadRequest(String),
}

impl IntoResponse for ServiceError {
    fn into_response(self) -> axum::response::Response {
        match self {
            ServiceError::DatabaseError(DatabaseError::NotFound) => {
                tracing::info!(%self);
                (StatusCode::NOT_FOUND, "not found").into_response()
            }
            ServiceError::BadRequest(err) => {
                tracing::debug!(err);
                (StatusCode::BAD_REQUEST, "bad request").into_response()
            }
        }
    }
}
