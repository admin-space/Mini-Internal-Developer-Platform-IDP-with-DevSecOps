from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    APP_NAME: str = "Mini IDP Backend"
    DATABASE_URL: str = "sqlite:///./app.db"
    
    class Config:
        env_file = ".env"

settings = Settings()
