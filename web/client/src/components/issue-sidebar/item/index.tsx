import React, {useState} from 'react'
import * as S from './style'

interface IssueSideBarItemProps {
  menuName: string,
  children: React.ReactNode
}

export default function IssueSideBarItem({menuName, children} : IssueSideBarItemProps) {
  const [isHover, setIsHover] = useState<boolean>(false);

  return (
    <S.ItemWrapper>
      <S.ItemHead>
        <S.MenuName onMouseEnter={() => setIsHover(true)} onMouseLeave={() => setIsHover(false)} isHover={isHover}>{menuName}</S.MenuName>
        <S.SettingIcon onMouseEnter={() => setIsHover(true)} onMouseLeave={() => setIsHover(false)} isHover={isHover}/>
      </S.ItemHead>

      <S.ItemBody>
        {children}
      </S.ItemBody>
    </S.ItemWrapper>
  )
}
