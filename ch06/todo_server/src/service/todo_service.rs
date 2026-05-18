use std::sync::Arc;

use tokio::sync::Mutex;

use crate::{
    database::inmemory::InMemoryTodoDatabase, model::todo::Todo, service::error::ServiceError,
};

#[derive(Clone)]
pub struct TodoService {
    database: Arc<Mutex<InMemoryTodoDatabase>>,
}
impl TodoService {
    pub fn new(database: Arc<Mutex<InMemoryTodoDatabase>>) -> TodoService {
        TodoService { database }
    }

    pub async fn create_todo(&self, todo: Todo) -> Result<Todo, ServiceError> {
        let todo = self.database.lock().await.create(todo).await?;

        Ok(todo)
    }

    pub async fn get_all(&self) -> Result<Vec<Todo>, ServiceError> {
        let todos = self.database.lock().await.get_all().await?;

        Ok(todos)
    }

    pub async fn update(&self, todo: Todo) -> Result<Todo, ServiceError> {
        let todo = self.database.lock().await.update(todo).await?;

        Ok(todo)
    }

    pub async fn delete(&self, id: String) -> Result<(), ServiceError> {
        self.database.lock().await.delete(id).await?;

        Ok(())
    }
}

impl Default for InMemoryTodoDatabase {
    fn default() -> Self {
        Self::new()
    }
}
