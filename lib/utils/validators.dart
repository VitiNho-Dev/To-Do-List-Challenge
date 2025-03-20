mixin Validators {
  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'O nome da tarefa não pode ser vazio';
    }
    return null;
  }
}
