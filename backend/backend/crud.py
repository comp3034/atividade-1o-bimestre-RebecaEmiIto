from sqlalchemy.orm import Session

from backend.main import create_measure
from . import models, schemas


### User
def get_user(db: Session, user_id: int):
    return db.query(models.User).filter(models.User.id == user_id).first()

def get_user_by_email(db: Session, email: str):
    return db.query(models.User).filter(models.User.email == email).first()

def get_users(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.User).offset(skip).limit(limit).all()


### User Create
def create_user(db: Session, user: schemas.UserCreate):
    fake_hashed_password = user.password + "notreallyhashed"
    db_user = models.User(
        name=user.name, 
        email=user.email, 
        hashed_password=fake_hashed_password
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user


### User Edit
def edit_user(db: Session, user_id: int, new_value):
    user = schemas.UserEdit
    db_user = models.User[user_id](
        name=user.name, 
        email=user.email,
        birth_date=user.birth_date,
    )
    db.commit()
    db.refresh(db_user)
    return db_user


### Measure
def get_measures(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Measure).offset(skip).limit(limit).all()


### User Measure
def get_user_measure(db: Session, user_id: int):
    return db.query(models.User).filter(models.User.id == user_id).first()


### Measure Create
def create_user_measure(db: Session, measure: schemas.MeasureCreate, user_id: int):
    db_measure = models.Measure(
        **measure.dict(), 
        owner_id=user_id
    )
    db.add(db_measure)
    db.commit()
    db.refresh(db_measure)
    return db_measure