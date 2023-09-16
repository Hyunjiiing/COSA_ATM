from fastapi import FastAPI, File, UploadFile
from starlette.responses import FileResponse
import uvicorn
import model

#uvicorn main:app --reload
app = FastAPI()
path = 'images/download.jpeg'

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/user/{name}")
def read_user_name(name: str):
    return {"name": model.classify_image(path)}

#파일 다운로드
@app.get("/images/{filename}")
def read_item(filename):
    targetFile = path + filename
    print(f"File Download : {targetFile}")
    return FileResponse(targetFile, media_type = 'image/jpg', filename = filename)