from typing import List

from sqlalchemy.sql.functions import user

from fastapi import Depends, FastAPI, HTTPException
from sqlalchemy.orm import Session

from . import crud, models, schemas
from .database import SessionLocal, engine
from fastapi.encoders import jsonable_encoder

models.Base.metadata.create_all(bind=engine)

app = FastAPI()


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


### User
@app.post("/users/", response_model=schemas.User)
def create_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    db_user = crud.get_user_by_email(db, email=user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="E-mail já cadastrado")

    return crud.create_user(db=db, user=user)


@app.get("/users/", response_model=List[schemas.User])
def read_users(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    users = crud.get_users(db, skip=skip, limit=limit)
    return users


# User info
@app.get("/users/{user_id}", response_model=schemas.User)
def find_user(user_id: int, db: Session = Depends(get_db)):
    return crud.get_user(db, user_id)



@app.put("/users/{user_id}/", response_model=schemas.User)
async def edit_user(user_id: int, new_value: schemas.UserEdit, db: Session = Depends(get_db)):
    db_user = crud.get_user(db, user_id)
    if db_user:
        return crud.edit_user(db, user, new_value)
    raise HTTPException(status_code=400, detail="O usuário não existe")


# Measure
@app.get("/measure/", response_model=List[schemas.Measure])
def read_measures(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return crud.get_measures(db, skip, limit)


@app.post("/users/{user_id}/measure/", response_model=schemas.Measure)
def create_measure(user_id: int, measure: schemas.Measure, db: Session = Depends(get_db)):
    db_user = crud.get_user(db, user_id)
    if db_user:
        return crud.create_user_measure(db, measure, id)
    raise HTTPException(status_code=400, detail="Usuário inexistente")


@app.get("/users/{user_id}/measure/", response_model=List[schemas.Measure])
def get_users_measure(user_id: int, db: Session = Depends(get_db)):
    db_user = crud.get_user_by_email(db, user_id)
    if db_user:
        return crud.create_user_measure(db, id)
    raise HTTPException(status_code=400, detail="Usuário inexistente")