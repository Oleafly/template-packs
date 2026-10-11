export type User = {
  id: bigint;
  name: string;
};

export interface UserRepository {
  findById(id: bigint): Promise<User | null>;
}

export const findUser = async (
  repository: UserRepository,
  id: bigint,
): Promise<User | null> => {
  return repository.findById(id);
};
