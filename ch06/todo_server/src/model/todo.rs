use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use utoipa::ToSchema;

#[derive(Serialize, Deserialize, Clone, ToSchema)]
pub struct Todo {
    pub id: String,
    pub title: String,
    pub description: String,
    pub completed: bool,
    pub created_at: DateTime<Utc>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub updated_at: Option<DateTime<Utc>>,
    pub priority: Priority,
}

#[derive(Serialize, Deserialize, Clone, ToSchema)]
pub enum Priority {
    #[serde(rename = "normal")]
    Normal,
}
