# Documentação das rotas

## Usuários - Index
Lista todos os users

#GET

_/users_

## Usuários - Show
#GET

Lista apenas um user, passando o ID do user como parâmetro

_/users/:id_

## Tarefas - Index
#GET

Lista todas tarefas

_/tasks_

![image](https://github.com/user-attachments/assets/942e8005-a5f5-4713-b99b-35891c8f02aa)

## Tarefas - Show
#GET

Lista apenas uma tarefa, passando o ID da task como parâmetro

_/tasks/:id_

![image](https://github.com/user-attachments/assets/5c4c4994-8e8e-4c54-934f-631bafeb386c)

## Comentários - Index
#GET

Lista todos os comentários

_/comments_

![image](https://github.com/user-attachments/assets/b7e09530-50eb-423e-a49a-362df970c5df)

## Comentários - Show
#GET

Lista apenas um comentário, passando o ID do comentário como parâmetro

_/comments/:id_

![image](https://github.com/user-attachments/assets/0c874335-62a2-432e-a865-92c63892887b)

## Comentários de um Comentário 
#GET

Lista todos os comentários de um comentário específico, passando o ID do comentário como parâmetro

_/comments/:id/comment_

![image](https://github.com/user-attachments/assets/9f6a03af-52c2-4811-b726-96e3703a81ef)

## Criar Tarefas
#POST

Cria uma tarefa

_/tasks_

## Criar Usuários
#POST

Cria um user

_/users_

## Criar Comentários
#POST

Cria um comentário

_/comments_

## Editar Tarefas
#PATCH

Edita uma tarefa, passando o ID da task como parâmetro

_/tasks/:id_

## Editar Usuários
#PATCH

Edita um user, passando o ID do user como parâmetro

_/users/:id_

## Editar Comentários
#PATCH

Edita um comentário, passando o ID do comentário como parâmetro

_/comments/:id_

## Remover Tarefas
#DELETE

Remove uma task, passando o ID da task como parâmetro

_/tasks/:id_

## Remover Usuários
#DELETE

Remove um user, passando o ID do user como parâmetro

_/users/:id_

## Remover Comentário
#DELETE

Remove um comentário, passando o ID do comentário como parâmetro

_/comments/:id_

## Remover anexo da tarefa
#PATCH

Remove a imagem anexada à uma task, passando o ID da task como parâmetro

_/tasks/:id/remove_image_

## Situações da Task
#GET

Mostra as situações da task

_/tasks_enum

## Adicionar um usuário à Task
#PATCH

Relaciona uma task à um usuário

_/tasks/:id/add_user_


