
import os

from fastapi import FastAPI

app = FastAPI(
    title="AWS Infrastructure Automation API",
    description="DevOps 및 AWS 인프라 운영 실습용 API",
    version="0.1.0",
)


@app.get("/")
def root():
    return {
        "service": "aws-infra-automation",
        "message": "FastAPI server is running",
    }


@app.get("/health/live")
def liveness():
    return {
        "status": "alive",
    }


@app.get("/health/ready")
def readiness():
    # 현재는 DB 등 외부 의존성이 없는 상태
    return {
        "status": "ready",
        "checks": {
            "application": "ok",
        },
    }


@app.get("/api/version")
def get_version():
    return {
        "service": "aws-infra-automation",
        "version": os.getenv("APP_VERSION", "0.1.0"),
        "environment": os.getenv("APP_ENV", "local"),
    }
