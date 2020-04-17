import React from 'react';
import { TextField } from "react-admin"
import { checkPropTypes } from 'prop-types';

interface IMyTextFieldProps {
  record?: {};
  source: string;
  id?: string;
  label?: string;
}

export default class MyTextField extends React.Component<IMyTextFieldProps> {

  private getValue(): string {
    const {
      record,
      source
    } = this.props;

    return record[source];
  }

  public render() {
    const {
      id,
      label,
      source,
      record
    } = this.props;

    return (
      <TextField
        source={source}
        record={record}
      />
    );
  }
}