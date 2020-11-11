const URL = "http://118.67.134.194:3000";

export const getLabels = async () => {
  const result = await fetch(`${URL}/api/label`, {
    method: "GET",
  });
  if (!result.ok) return;

  const labelList = await result.json();
  return labelList;
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
  const res = await fetch(`${URL}/api/`, {
    method: 'POST', 
    body: JSON.stringify({userId, issueId, content}), 
    headers:{
      'Content-Type': 'application/json'
    }
  })

  if(!res.ok) return;
  return await res.json();
}

