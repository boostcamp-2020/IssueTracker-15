import { useState } from "react";

function useToggle(initialForm: boolean): any[] {
  const [isOpen, setIsOpen] = useState(initialForm);
  const toggle = () => setIsOpen(!isOpen);
  return [isOpen, toggle];
}

export default useToggle;
