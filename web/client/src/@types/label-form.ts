export default interface Label {
  id: number;
  title: string;
  description: string;
  color: string;
}

export interface PostLabel {
  id?: number;
  title?: string;
  description?: string;
  color?: string;
}
