from flask import Flask, request, jsonify
from threading import Thread
from tools.analysis import lanzar_analisis

app = Flask(__name__)

@app.get("/healthz")
def healthz():
    return jsonify(status="ok"), 200

@app.route("/analizar", methods=["POST"])
def analizar():
    try:
        params = request.get_json()
        campos_obligatorios = [
            'id_tarea',
            'postprocess'
        ]
        for campo in campos_obligatorios:
            if campo not in params:
                print(f"Campo faltante: {campo}")
                return jsonify({'error': f'Falta el campo: {campo}'}), 400
        postprocess = int(params['postprocess'])
        thread = Thread(target=lanzar_analisis, args=(postprocess, params['id_tarea']))
        thread.start()

        return jsonify({
            "mensaje": "Inferencia iniciada en background"
        }), 202 

    except Exception as e:
        print(f"Error al iniciar la inferencia: {str(e)}")
        return jsonify({'error': str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5004)