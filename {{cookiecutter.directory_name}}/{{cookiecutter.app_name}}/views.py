from flask import Blueprint, request, send_from_directory

bp = Blueprint(
    "views",
    __name__,
    url_prefix="",
    template_folder="templates",
    static_folder="static",
)


@bp.route("/")
def index():
    """Route for index page."""
    return send_from_directory("templates", "index.html")

@bp.route("/static/<path:path>")
def send_js(path):
    """ Route for static resources."""
    return send_from_directory("static", path)