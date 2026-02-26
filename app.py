from flask import Flask
from extensions import db
from routes import students_v1, students_v2, students_legacy
import os


def create_app():
    app = Flask(__name__)
#    app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///students.db"
    app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv("DATABASE_URL")
    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

    db.init_app(app)
    with app.app_context():
        db.create_all()

    # Versioned
    app.register_blueprint(students_v1, url_prefix="/api/v1/students")
    app.register_blueprint(students_v2, url_prefix="/api/v2/students")

    # Backward compatibility
    app.register_blueprint(students_legacy, url_prefix="/students")

    @app.get("/health")
    def health():
        return {"status": "ok"}

    return app


if __name__ == "__main__":
    create_app().run(host="0.0.0.0", port=5000, debug=True)
