use std::collections::HashMap;

use crate::model::todo::Todo;

#[derive(Debug, thiserror::Error)]
pub enum DatabaseError {
    #[error("not found")]
    NotFound,
}

#[derive(Clone)]
pub struct InMemoryTodoDatabase {
    /// 키는 id이다.
    todos: HashMap<String, Todo>,
}

impl InMemoryTodoDatabase {
    pub fn new() -> Self {
        Self {
            todos: HashMap::new(),
        }
    }

    pub async fn get_all(&self) -> Result<Vec<Todo>, DatabaseError> {
        let mut todos = self.todos.values().cloned().collect::<Vec<_>>();
        todos.sort_by_key(|todo| todo.id.clone());

        Ok(todos)
    }

    pub async fn create(&mut self, todo: Todo) -> Result<Todo, DatabaseError> {
        self.todos.insert(todo.id.clone(), todo.clone());
        Ok(todo)
    }

    pub async fn update(&mut self, todo: Todo) -> Result<Todo, DatabaseError> {
        let old_todo = self.todos.get_mut(&todo.id).ok_or_else(|| {
            tracing::debug!(id = %todo.id, "존재하지 않는 일정");
            DatabaseError::NotFound
        })?;

        *old_todo = todo.clone();

        Ok(todo)
    }

    pub async fn delete(&mut self, id: String) -> Result<(), DatabaseError> {
        if self.todos.remove(&id).is_none() {
            tracing::debug!(id = %id, "존재하지 않는 일정");
            return Err(DatabaseError::NotFound);
        }

        Ok(())
    }
}
