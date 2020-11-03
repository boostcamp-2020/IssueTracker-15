export interface Label {
  title: string;
  description?: string;
  color: string;
}

export interface LabelUpdateToFix {
  title?: string;
  description?: string;
  color?: string;
}
