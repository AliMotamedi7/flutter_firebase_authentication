abstract class BaseStatus {}

class BaseSuccess<T> implements BaseStatus {
  final T entity;

  BaseSuccess(this.entity);
}

class BaseNoAction implements BaseStatus {
  const BaseNoAction();
}

class BaseLoading implements BaseStatus {
  const BaseLoading();
}

class BaseError implements BaseStatus {
  final String? error;

  const BaseError(this.error);
}

class NoParams {}
