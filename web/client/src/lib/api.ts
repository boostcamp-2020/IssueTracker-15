import {URL} from '../config/apiConfig'

export const getMilestones = async () => {
  const result = await fetch(`${URL}/api/milestone`, {
    method: "GET",
  });
  if (!result.ok) return;

  const milestoneList = await result.json();
  return milestoneList;
};

export const getIssues = async (isOpened: boolean) => {
  const result = await fetch(`${URL}/api/issue?isOpened=${isOpened}`, {
    method: "GET",
  });
  if (!result.ok) return;

  const issueList = await result.json();
  return issueList;
};

export const getLabels = async () => {
  const result = await fetch(`${URL}/api/label`, {
    method: "GET",
  });
  if (!result.ok) return;

  const labelList = await result.json();
  return labelList;
};

export const deleteLabelReqeust = async (labelId: number) => {
  const result = await fetch(`${URL}/api/label/${labelId}`, {
    method: "DELETE",
  });
  return result;
};


export const getIssueById = async (id: number) => {
  const res = await fetch(
    `${URL}/api/issue/${id}`
  );

  if(!res.ok) return;
  const issue = await res.json();
  return issue;
};

interface CommentProps {
	  userId : number;
	  issueId : number;
    content :string;
}

export const postComment = async ({userId, issueId, content}: CommentProps ) => {
  const res = await fetch(`${URL}/api/comment`, {
    method: 'POST', 
    body: JSON.stringify({userId, issueId, content}), 
    headers:{
      'Content-Type': 'application/json'
    }
  })

  if(!res.ok) return false;
  return await res.json();
}

export const getJWTToken = async (code: string) => {
  const result = await fetch(`${URL}/api/signin/github`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      code,
    }),
  });
  const { accessToken } = await result.json();
  return accessToken;
};

export const updateIssueTitle = async (id: number, title: string) => {
  const result = await fetch(`${URL}/api/issue/${id}`, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      title
    }),
  })

  if(!result.ok) return false;
  return true;
};

  export const closeIssue = async (id: number) => {
    const result = await fetch(`${URL}/api/issue/${id}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        isOpened: false
      }),
    });

  if(!result.ok) return false;
  return true;
  };
