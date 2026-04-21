<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouveau tournoi | Gestion de tournois</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="custom-container">
    <!-- Header -->
    <div class="create-header">
        <h1>
            <i class="fas fa-plus-circle"></i>
            Création d'un tournoi
        </h1>
    </div>

    <!-- Formulaire -->
    <div class="create-form">
        <form method="post" action="${pageContext.request.contextPath}/tournaments">
            <!-- Section 1: Informations générales -->
            <div class="form-section">
                <div class="form-section-title">
                    <i class="fas fa-info-circle"></i>
                    <span>Informations générales</span>
                </div>
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label-custom">
                                <i class="fas fa-tag"></i>
                                Nom du tournoi
                                <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control-custom" name="name" 
                                   placeholder="Ex: Coupe du Monde 2024" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label-custom">
                                <i class="fas fa-futbol"></i>
                                Sport
                                <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control-custom" name="sport" 
                                   placeholder="Ex: Football, Basketball, Tennis..." required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label-custom">
                                <i class="fas fa-chart-line"></i>
                                Type de tournoi
                                <span class="required">*</span>
                                <i class="fas fa-question-circle info-tooltip" 
                                   title="Championnat : Tous contre tous | Élimination directe : Matchs à élimination"></i>
                            </label>
                            <select class="form-control-custom" name="type" required>
                                <option value="CHAMPIONNAT">🏆 Championnat (Round-robin)</option>
                                <option value="KO">🎯 Élimination directe (KO)</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label-custom">
                                <i class="fas fa-map-marker-alt"></i>
                                Lieu
                                <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control-custom" name="location" 
                                   placeholder="Ex: Stade de France, Paris" required>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Section 2: Dates -->
            <div class="form-section">
                <div class="form-section-title">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Calendrier</span>
                </div>
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label-custom">
                                <i class="fas fa-calendar-day"></i>
                                Date de début
                                <span class="required">*</span>
                            </label>
                            <input type="date" class="form-control-custom" name="startDate" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label-custom">
                                <i class="fas fa-calendar-check"></i>
                                Date de fin
                                <span class="required">*</span>
                            </label>
                            <input type="date" class="form-control-custom" name="endDate" required>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Section 3: Configuration des matchs -->
            <div class="form-section">
                <div class="form-section-title">
                    <i class="fas fa-clock"></i>
                    <span>Configuration des matchs</span>
                </div>
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label-custom">
                                <i class="fas fa-hourglass-half"></i>
                                Durée du match (minutes)
                                <span class="required">*</span>
                                <i class="fas fa-question-circle info-tooltip" 
                                   title="Durée standard : Football 90min, Basketball 40min, Tennis variable"></i>
                            </label>
                            <input type="number" class="form-control-custom" name="matchDurationMinutes" 
                                   min="10" value="90" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label-custom">
                                <i class="fas fa-map-marked-alt"></i>
                                Nombre de terrains disponibles
                                <span class="required">*</span>
                            </label>
                            <input type="number" class="form-control-custom" name="availableFields" 
                                   min="1" value="1" required>
                        </div>
                    </div>
                </div>
                
                <!-- Preview (optionnel) -->
                <div class="tournament-preview">
                    <p>
                        <i class="fas fa-chart-simple"></i>
                        <strong>Aperçu :</strong> Un tournoi de type <span id="typePreview">Championnat</span> 
                        sera créé du <span id="startPreview">--</span> au <span id="endPreview">--</span>
                    </p>
                </div>
            </div>

            <!-- Actions -->
            <div class="form-actions">
                <button type="submit" class="btn-save">
                    <i class="fas fa-save"></i> Créer le tournoi
                </button>
                <a href="${pageContext.request.contextPath}/tournament-dashboard" class="btn-cancel">
                    <i class="fas fa-times"></i> Annuler
                </a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Aperçu dynamique du formulaire
    const typeSelect = document.querySelector('select[name="type"]');
    const startDateInput = document.querySelector('input[name="startDate"]');
    const endDateInput = document.querySelector('input[name="endDate"]');
    const typePreview = document.getElementById('typePreview');
    const startPreview = document.getElementById('startPreview');
    const endPreview = document.getElementById('endPreview');
    
    if (typeSelect) {
        typeSelect.addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex].text;
            typePreview.textContent = selectedOption.replace(/[🏆🎯]/g, '').trim();
        });
    }
    
    if (startDateInput) {
        startDateInput.addEventListener('change', function() {
            startPreview.textContent = this.value || '--';
            // Vérification que la date de fin est après la date de début
            if (endDateInput.value && this.value > endDateInput.value) {
                endDateInput.value = this.value;
                endPreview.textContent = this.value;
                alert('La date de fin doit être postérieure à la date de début');
            }
        });
    }
    
    if (endDateInput) {
        endDateInput.addEventListener('change', function() {
            endPreview.textContent = this.value || '--';
            // Vérification que la date de fin est après la date de début
            if (startDateInput.value && this.value < startDateInput.value) {
                alert('La date de fin doit être postérieure à la date de début');
                this.value = startDateInput.value;
                endPreview.textContent = startDateInput.value;
            }
        });
    }
    
    // Validation avant soumission
    document.querySelector('form').addEventListener('submit', function(e) {
        const startDate = new Date(startDateInput.value);
        const endDate = new Date(endDateInput.value);
        
        if (startDate > endDate) {
            e.preventDefault();
            alert('La date de début doit être antérieure à la date de fin');
            return false;
        }
        
        const matchDuration = parseInt(document.querySelector('input[name="matchDurationMinutes"]').value);
        if (matchDuration < 10) {
            e.preventDefault();
            alert('La durée du match doit être d\'au moins 10 minutes');
            return false;
        }
        
        const availableFields = parseInt(document.querySelector('input[name="availableFields"]').value);
        if (availableFields < 1) {
            e.preventDefault();
            alert('Le nombre de terrains doit être au moins 1');
            return false;
        }
        
        return true;
    });
</script>
</body>
</html>