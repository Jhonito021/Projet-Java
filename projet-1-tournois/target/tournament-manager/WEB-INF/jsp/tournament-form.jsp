<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nouveau tournoi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <h1 class="h3 mb-3">Creation d'un tournoi</h1>
    <form method="post" action="<%= request.getContextPath() %>/tournaments" class="card card-body bg-white">
        <div class="row g-3">
            <div class="col-md-6">
                <label class="form-label">Nom</label>
                <input class="form-control" name="name" required>
            </div>
            <div class="col-md-6">
                <label class="form-label">Sport</label>
                <input class="form-control" name="sport" required>
            </div>
            <div class="col-md-6">
                <label class="form-label">Type</label>
                <select class="form-select" name="type" required>
                    <option value="CHAMPIONNAT">Championnat</option>
                    <option value="KO">Elimination directe</option>
                </select>
            </div>
            <div class="col-md-6">
                <label class="form-label">Lieu</label>
                <input class="form-control" name="location" required>
            </div>
            <div class="col-md-6">
                <label class="form-label">Date debut</label>
                <input class="form-control" type="date" name="startDate" required>
            </div>
            <div class="col-md-6">
                <label class="form-label">Date fin</label>
                <input class="form-control" type="date" name="endDate" required>
            </div>
            <div class="col-md-6">
                <label class="form-label">Duree match (minutes)</label>
                <input class="form-control" type="number" min="10" name="matchDurationMinutes" required>
            </div>
            <div class="col-md-6">
                <label class="form-label">Nombre de terrains</label>
                <input class="form-control" type="number" min="1" name="availableFields" required>
            </div>
        </div>
        <div class="mt-3 d-flex gap-2">
            <button class="btn btn-primary" type="submit">Enregistrer</button>
            <a class="btn btn-secondary" href="<%= request.getContextPath() %>/">Retour</a>
        </div>
    </form>
</div>
</body>
</html>
